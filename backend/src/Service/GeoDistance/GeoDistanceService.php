<?php

namespace App\Service\GeoDistance;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceConstant;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Request\Order\OrderDeliveryCostByExternalStoreOwnerGetRequest;
use App\Response\GeoDistance\GeoDistanceInfoGetResponse;
use App\Response\GeoDistance\GetDistanceWithDeliveryCostGetForExternalStoreResponse;
use App\Service\StoreOwnerBranch\StoreBranchGetForGeoDistanceService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Service\Subscription\SubscriptionService;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;

class GeoDistanceService
{
    private $key;

    public function __construct(
        private AutoMapping $autoMapping,
        private HttpClientInterface $httpClient,
        ParameterBagInterface $params,
        private SubscriptionService $subscriptionService,
        private StoreBranchGetForGeoDistanceService $storeBranchGetForGeoDistanceService
    )
    {
        $this->key = $params->get('google_maps_api_key');
    }

    public function getGeoDistanceBetweenTwoLocations(float $originLat, float $originLng, float $destinationLat, float $destinationLng): GeoDistanceInfoGetResponse|int
    {
        $url = GeoDistanceConstant::GOOGLE_MAPS_DISTANCE_MATRIX_URL_CONST
            .'destinations='.$originLat.'%2C'.$originLng
            .'&origins='.$destinationLat.'%2C'.$destinationLng
            .'&key='.$this->key;

        $response = $this->httpClient->request('GET', $url);

        $jsonResponse = json_decode($response->getContent(), true);

        if (! empty($jsonResponse)) {
            if (isset($jsonResponse['rows'])) {
                if (! empty($jsonResponse['rows'])) {
                    if (! empty($jsonResponse['rows'][0])) {
                        if (! empty($jsonResponse['rows'][0]['elements'])) {
                            if (! empty($jsonResponse['rows'][0]['elements'][0])) {
                                $response = [];

                                if ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::ZERO_RESULTS_STATUS_CONST) {
                                    $response['distance'] = GeoDistanceResultConstant::ZERO_DISTANCE_CONST;

                                } elseif ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::OK_STATUS_CONST) {
                                    $response['distance'] = trim($jsonResponse['rows'][0]['elements'][0]['distance']['text'], " km");
                                }

                                return $this->autoMapping->map('array', GeoDistanceInfoGetResponse::class, $response);
                            }
                        }
                    }
                }

                return GeoDistanceResultConstant::BAD_REQUEST_CONST;
            }
        }

        return GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED;
    }

    public function fetchCostDeliveredGeoDistanceBetweenTwoLocationsForStore(float $originLat, float $originLng, float $destinationLat, float $destinationLng, int $userId): GeoDistanceInfoGetResponse|int
    {
        $url = GeoDistanceConstant::GOOGLE_MAPS_DISTANCE_MATRIX_URL_CONST
            .'destinations='.$originLat.'%2C'.$originLng
            .'&origins='.$destinationLat.'%2C'.$destinationLng
            .'&key='.$this->key;

        $response = $this->httpClient->request('GET', $url);

        $jsonResponse = json_decode($response->getContent(), true);

        if (! empty($jsonResponse)) {
            if (isset($jsonResponse['rows'])) {
                if (! empty($jsonResponse['rows'])) {
                    if (! empty($jsonResponse['rows'][0])) {
                        if (! empty($jsonResponse['rows'][0]['elements'])) {
                            if (! empty($jsonResponse['rows'][0]['elements'][0])) {
                                $response = [];

                                if ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::ZERO_RESULTS_STATUS_CONST) {
                                    $response['distance'] = GeoDistanceResultConstant::ZERO_DISTANCE_CONST;

                                } elseif ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::OK_STATUS_CONST) {
                                    $response['distance'] = trim($jsonResponse['rows'][0]['elements'][0]['distance']['text'], " km");

                                    // check if distance has comma (it has when it is consists of four digits)
                                    // if it has comma, then remove it
                                    if (str_contains($response['distance'], ',')) {
                                        $response['distance'] = str_replace(',', '', $response['distance']);
                                    }

                                    $response['costDeliveryOrder'] = $this->calculateCostDeliveryOrder($userId, $response['distance']);
                                }

                                return $this->autoMapping->map('array', GeoDistanceInfoGetResponse::class, $response);
                            }
                        }
                    }
                }

                return GeoDistanceResultConstant::BAD_REQUEST_CONST;
            }
        }

        return GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED;
    }

    public function fetchCostDeliveredGeoDistanceBetweenTwoLocationsForAdmin(float $originLat, float $originLng, float $destinationLat, float $destinationLng, int $storeOwnerProfileId): GeoDistanceInfoGetResponse|int
    {
        $url = GeoDistanceConstant::GOOGLE_MAPS_DISTANCE_MATRIX_URL_CONST
            .'destinations='.$originLat.'%2C'.$originLng
            .'&origins='.$destinationLat.'%2C'.$destinationLng
            .'&key='.$this->key;

        $response = $this->httpClient->request('GET', $url);

        $jsonResponse = json_decode($response->getContent(), true);

        if (! empty($jsonResponse)) {
            if (isset($jsonResponse['rows'])) {
                if (! empty($jsonResponse['rows'])) {
                    if (! empty($jsonResponse['rows'][0])) {
                        if (! empty($jsonResponse['rows'][0]['elements'])) {
                            if (! empty($jsonResponse['rows'][0]['elements'][0])) {
                                $response = [];

                                if ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::ZERO_RESULTS_STATUS_CONST) {
                                    $response['distance'] = GeoDistanceResultConstant::ZERO_DISTANCE_CONST;

                                } elseif ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::OK_STATUS_CONST) {
                                    $response['distance'] = trim($jsonResponse['rows'][0]['elements'][0]['distance']['text'], " km");

                                    // check if distance has comma (it has when it is consists of four digits)
                                    // if it has comma, then remove it
                                    if (str_contains($response['distance'], ',')) {
                                        $response['distance'] = str_replace(',', '', $response['distance']);
                                    }

                                    $response['costDeliveryOrder'] = $this->calculateCostDeliveryOrderForAdmin($response['distance'], $storeOwnerProfileId);
                                }

                                return $this->autoMapping->map('array', GeoDistanceInfoGetResponse::class, $response);
                            }
                        }
                    }
                }

                return GeoDistanceResultConstant::BAD_REQUEST_CONST;
            }
        }

        return GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED;
    }

    public function calculateCostDeliveryOrder(int $userId, $distance): CalculateCostDeliveryOrderResponse
    {
        $request = new CalculateCostDeliveryOrderRequest();

        $request->setStoreOwner($userId);
        $request->setStoreBranchToClientDistance((float) $distance);

        return $this->subscriptionService->calculateCostDeliveryOrder($request);
    }

    public function calculateCostDeliveryOrderForAdmin($distance, int $storeOwnerProfileId): CalculateCostDeliveryOrderResponse
    {
        
        $request = new AdminCalculateCostDeliveryOrderRequest();
        
        $request->setStoreOwnerProfileId($storeOwnerProfileId);
        $request->setStoreBranchToClientDistance((float) $distance);

        return $this->subscriptionService->calculateCostDeliveryOrderForAdmin($request);
    }

    /**
     * Get a specific store's branch location by branch id
     */
    public function getStoreBranchLocationById(int $branchId): array|string
    {
        return $this->storeBranchGetForGeoDistanceService->getStoreBranchLocationById($branchId);
    }

    /**
     * Calculates the distance between the store's branch and the client location and get the delivery cost according
     * on the calculated distance for en external store on Masdar
     */
    public function getDeliveryCostForExternalStoreOwner(OrderDeliveryCostByExternalStoreOwnerGetRequest $request): string|GetDistanceWithDeliveryCostGetForExternalStoreResponse|int
    {
        // 1. Calculate the distance between the store's branch and the client's location
        // --- Get the coordinates of the store's branch
        $storeBranchLocation = $this->getStoreBranchLocationById($request->getStoreBranchId());

        if ($storeBranchLocation === StoreOwnerBranch::BRANCH_NOT_FOUND) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        // 2. Calculate the delivery cost depending on the calculated distance
        $url = GeoDistanceConstant::GOOGLE_MAPS_DISTANCE_MATRIX_URL_CONST
            .'destinations='.$storeBranchLocation['lat'].'%2C'.$storeBranchLocation['lon']
            .'&origins='.$request->getClientLocation()['lat'].'%2C'.$request->getClientLocation()['lon']
            .'&key='.$this->key;

        $response = $this->httpClient->request('GET', $url);

        $jsonResponse = json_decode($response->getContent(), true);

        if (! empty($jsonResponse)) {
            if (isset($jsonResponse['rows'])) {
                if (! empty($jsonResponse['rows'])) {
                    if (! empty($jsonResponse['rows'][0])) {
                        if (! empty($jsonResponse['rows'][0]['elements'])) {
                            if (! empty($jsonResponse['rows'][0]['elements'][0])) {
                                $response = [];

                                if ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::ZERO_RESULTS_STATUS_CONST) {
                                    $response['distance'] = GeoDistanceResultConstant::ZERO_DISTANCE_CONST;

                                } elseif ($jsonResponse['rows'][0]['elements'][0]['status'] === GeoDistanceResultConstant::OK_STATUS_CONST) {
                                    $response['distance'] = trim($jsonResponse['rows'][0]['elements'][0]['distance']['text'], " km");

                                    // check if distance has comma (it has when it is consists of four digits)
                                    // if it has comma, then remove it
                                    if (str_contains($response['distance'], ',')) {
                                        $response['distance'] = str_replace(',', '', $response['distance']);
                                    }

                                    $response['costDeliveryOrder'] = $this->calculateCostDeliveryOrderForAdmin($response['distance'],
                                        $request->getStoreOwnerProfileId());
                                }

                                return $this->autoMapping->map('array', GetDistanceWithDeliveryCostGetForExternalStoreResponse::class,
                                    $response);
                            }
                        }
                    }
                }

                return GeoDistanceResultConstant::BAD_REQUEST_CONST;
            }
        }

        return GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED;
    }
}

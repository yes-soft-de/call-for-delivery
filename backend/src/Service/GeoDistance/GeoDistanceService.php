<?php

namespace App\Service\GeoDistance;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceConstant;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Response\GeoDistance\GeoDistanceInfoGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Service\Subscription\SubscriptionService;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;

class GeoDistanceService
{
    private AutoMapping $autoMapping;
    private HttpClientInterface $httpClient;
    private $key;
    private $subscriptionService;

    public function __construct(AutoMapping $autoMapping, HttpClientInterface $httpClient, ParameterBagInterface $params, SubscriptionService $subscriptionService)
    {
        $this->autoMapping = $autoMapping;
        $this->httpClient = $httpClient;
        $this->key = $params->get('google_maps_api_key');
        $this->subscriptionService = $subscriptionService;
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
        $request->setStoreBranchToClientDistance($distance);

        return $this->subscriptionService->calculateCostDeliveryOrderForAdmin($request);
    }
}

<?php

namespace App\Service\GeoDistance;

use App\AutoMapping;
use App\Constant\GeoDistance\GeoDistanceConstant;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Response\GeoDistance\GeoDistanceInfoGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;

class GeoDistanceService
{
    private AutoMapping $autoMapping;
    private HttpClientInterface $httpClient;
    private $key;

    public function __construct(AutoMapping $autoMapping, HttpClientInterface $httpClient, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->httpClient = $httpClient;
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
                            if (! empty($jsonResponse['rows'][0]['elements'])) {
                                if (! empty($jsonResponse['rows'][0]['elements'][0])) {
                                    $response = [];

                                    $response['distance'] = trim($jsonResponse['rows'][0]['elements'][0]['distance']['text'], " km");

                                    return $this->autoMapping->map('array', GeoDistanceInfoGetResponse::class, $response);
                                }
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

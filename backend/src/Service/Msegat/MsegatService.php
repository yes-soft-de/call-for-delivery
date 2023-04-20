<?php

namespace App\Service\Msegat;

use App\Constant\HTTP\HttpMethodConstant;
use App\Constant\Msegat\MsegatParameterConstant;
use App\Constant\Msegat\MsegatURLConstant;
use App\Constant\Msegat\MsegatUserSenderConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

class MsegatService
{
    private $userName;

    private $apiKey;

    public function __construct(
        private ParameterBagInterface $params,
        private HttpClientInterface $client
    )
    {
    }

    public function setUserName($userName): void
    {
        $this->userName = $userName;
    }

    public function setApiKey($apiKey): void
    {
        $this->apiKey = $apiKey;
    }

    public function initializeSendSMSBodyRequest(string $phone, string $messageText): array
    {
        return [
            MsegatParameterConstant::USER_NAME_PARAM_CONST => $this->userName,
            MsegatParameterConstant::NUMBERS_PARAM_CONST => $phone,
            MsegatParameterConstant::USER_SENDER_PARAM_CONST => MsegatUserSenderConstant::USER_SENDER_CONST,
            MsegatParameterConstant::API_KEY_PARAM_CONST => $this->apiKey,
            MsegatParameterConstant::MSG_PARAM_CONST => $messageText
        ];
    }

    public function createPostRequestForSendingSMSMessage(string $url, array $body): ResponseInterface
    {
        return $this->client->request(HttpMethodConstant::POST_METHOD_CONST, $url, ['json' => $body]);
    }

    public function sendSMSMessage(string $phone, string $messageText): array
    {
        $this->setUserName($this->params->get('msegat_username'));
        $this->setApiKey($this->params->get('msegat_api_key'));

        $jsonBodyRequest = $this->initializeSendSMSBodyRequest($phone, $messageText);

        $response = $this->createPostRequestForSendingSMSMessage(
            MsegatURLConstant::BASE_URL_CONST .MsegatURLConstant::SEND_SMS_URL_PREFIX_CONST,
            $jsonBodyRequest
        );

        // trying to get the response content will block the execution until
        // the full response content is received
        return json_decode($response->getContent(), true);
    }
}

<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\AbstractNormalizer;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\SerializerInterface;

class BaseController extends AbstractController
{
    private $serializer;
    private $statusCode;

    public function __construct(SerializerInterface $serializer)
    {
        $this->serializer = $serializer;
    }
    const STATE_OK = 200;
    const CREATE = ["created ","201"];
    const UPDATE = ["updated","204"];
    const DELETE = ["deleted","401"];
    const FETCH = ["fetched","200"];
    //error order
    const ERROR = ["error","9201"];
    const ERROR_ORDER_REMOVE_CAPTAIN_RECEIVE = ["can not remove it, The captain received the order","9202"];
    const ERROR_ORDER_REMOVE_TIME = ["can not remove it, Exceeded time allowed","9206"];
    const ERROR_ORDER_UPDATE = ["error","9203"];
    const ERROR_ORDER_CAN_NOT_CREATE = ["error","9204"];
    const ERROR_ORDER_NOT_FOUND = ["error","9205"];
    //error related
    const ERROR_RELATED= ["error related","9251"];
    // error users
    const ERROR_USER_CHECK = ["error user check","9000"];
    const ERROR_USER_FOUND = ["error user found","9001"];
    const ERROR_UNMATCHED_PASSWORDS = ["password and its confirmation are not matched", "9002"];
    const ERROR_USER_TYPE = ["wrong user type", "9004"];
    const ERROR_USER_NOT_FOUND = ["error user not found", "9005"];
    const ERROR_USER_CREATED = ["error, not created user","9010"];
    // error captain
    const ERROR_CAPTAIN_INACTIVE = ["error captain inactive","9100"];
    const CAPTAIN_PROFILE_NOT_EXIST = ["captain profile not exist!", "9101"];
    const CAPTAIN_PROFILE_CREATED = ["captain profile created!", "9103"];
    const CAPTAIN_PROFILE_COMPLETED = ["captain profile created!", "9102"];
    const CAPTAIN_PROFILE_SYSTEM_FINANCIAL_SELECTED = ["captain profile created!", "9104"];
    //error store
    const ERROR_STORE_INACTIVE = ["error store inactive","9151"];
    const INCORRECT_ENTERED_DATA = ["incorrect entered date!", "9152"];
    const CODE_DATE_IS_NOT_VALID = ["overdue cod!", "9153"];
    const ALREADY_VERIFIED_STORE_OWNER = ["already verified store owner!", "9154"];
    const STORE_OWNER_IS_NOT_REGISTERED = ["store owner is not registered!", "9155"];
    const STORE_OWNER_IS_NOT_VERIFIED = ["store owner is not verified!", "9156"];
    const STORE_OWNER_PROFILE_NOT_EXIST = ["store owner profile not exist!", "9157"];
    const STORE_OWNER_PROFILE_CREATED = ["store owner profile created", "9158"];
    const STORE_OWNER_SUBSCRIPTION_CREATED = ["store owner profile created", "9159"];
    const STORE_OWNER_BRANCH_CREATED = ["store owner branch created", "9160"];
    const STORE_OWNER_PROFILE_COMPLETED = ["store owner profile completed", "9161"];
    // client
    const CLIENT_PROFILE_NOT_EXIST = ["client profile not exist!", "9210"];
    // subscription
    const SUBSCRIPTION_WAITE_ACTIVE = ["You have a subscription waiting to be activated", "9301"];
    const SUBSCRIPTION_UNSUBSCRIBED = ["You do not have a subscription", "9302"];
    const YOU_HAVE_SUBSCRIBED = ["You have subscribed", "9303"];
    const SUBSCRIBE_THEN_NEXT = ["Please subscribe first, then create a subscription for later", "9304"];
    const NOT_POSSIBLE = ["This subscription was previously extended, cannot be extended again", "9305"];
    const CAN_NOT_ACCEPTED_ORDER = ["The cars remaining is finished", "9306"];
    //profile not completed
    const PROFILE_NOT_COMPLETED = ["profile is not completed!", "9220"];
    const WRONG_COMPLETE_ACCOUNT_STATUS = ["wrong complete account status", "9221"];
    // company
    const COMPANY_INFO_NOT_EXISTS = ["required company info does not exist!", "9230"];
    // package
    const PACKAGE_NOT_EXIST = ["package not exist", "9351"];
    // package
    const CAPTAIN_OFFER_NOT_EXIST = ["captain offer not exist", "9451"];
    const ERROR_SUBSCRIPTION_CAN_NOT_CREATE_OFFER = ["error","9453"];
    const ERROR_YOU_HAVE_SUBSCRIPTION_ = ["you have subscription with captain offer","9454"];
    // notification
    const NOTIFICATION_NOT_FOUND = ["notification not exist", "9401"];
    // admin
    const ADMIN_PROFILE_NOT_EXIST = ["admin profile does not exist", "9410"];
    // supplier category
    const SUPPLIER_CATEGORY_NOT_EXIST = ["supplier category does not exist", "9550"];

    const NOTFOUND=["Not found", "404"];
    //payments
    const PAYMENT_NOT_EXIST = ["payment not exist!", "9501"];
    // supplier
    const SUPPLIER_PROFILE_NOT_EXIST = ["supplier profile not exist!", "9551"];

    const SUPPLIER_PROFILE_CREATED = ["supplier profile created", "9552"];
    const SUPPLIER_PROFILE_COMPLETED = ["supplier profile created", "9553"];
    //payments

    //CAPTAIN FINANCIAL SYSTEM
    const CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE = ["youHaveFinancialSystem,canNotChooseAnotherFinancialSystemNow", "9601"];
    const YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM = ["youNotHaveCaptainFinancialSystem", "9602"];
    // announcement
    const ANNOUNCEMENT_NOT_EXIST = ["announcement does not exist", "9440"];
    
//    const TEST = [
//        "one"=>[ "error error", "9003"],
//        "tow"=>[ "error captain inactive", "9002"]
//    ];

    public function getUserId()
    {
        $userID = 0;

        if ($this->getUser())
        {
            // $userID = $this->getUser()->getuserid();
            $userID = $this->getUser()->getId();
        }

        return $userID;
    }

    /**
     * @return mixed
     */
    public function getStatusCode()
    {
        return $this->statusCode;
    }

    /**
     * @param mixed $statusCode
     */
    public function setStatusCode($statusCode): void
    {
        $this->statusCode = $statusCode;
    }

    /**
     * Returns a JSON response
     *
     * @param array $data
     * @param array $headers
     *
     * @return JsonResponse
     */
    public function respond($data, $headers = [])
    {
        return new JsonResponse($data, self::STATE_OK, $headers);
    }

    /**
     * Sets an error message and returns a JSON response
     * @param string $errors
     * @param array $headers
     * @return JsonResponse
     */
    public function respondWithErrors($errors, $headers = [])
    {
        $data = [
            'errors' => $errors,
        ];

        return new JsonResponse($data, $this->getStatusCode(), $headers);
    }

    /**
     * Returns a 401 Unauthorized http response
     *
     * @param string $message
     *
     * @return JsonResponse
     */
    public function respondUnauthorized($message = 'Not authorized!')
    {
        $this->setStatusCode(401)->respondWithErrors($message);
    }

    /**
     * @param string $message
     * @return JsonResponse
     */
    public function respondNotFound($message = 'Not found!')
    {
        $data = [
            'Error' => $message,
        ];

        $this->setStatusCode(404);

        return new JsonResponse($data, $this->getStatusCode());
    }

    public function response($result, $status) :jsonResponse
    {
        if($result === "errorMsg")
        {
            $encoders = [new JsonEncoder()];
            $normalizers = [new ObjectNormalizer()];

            $this->serializer = new Serializer($normalizers, $encoders);
            $result = $this->serializer->serialize($result, "json", [
                'enable_max_depth' => true]);
            $response = new jsonResponse(["status_code" => $status[1],
                    "msg" => $status[0] . " " . "Error.",
                ]
                , Response::HTTP_OK);
            $response->headers->set('Access-Control-Allow-Headers', 'X-Header-One,X-Header-Two');
            $response->headers->set('Access-Control-Allow-Origin', '*');
            $response->headers->set('Access-Control-Allow-Methods', 'PUT');
            return $response;
        }
        
        if($result!=null)
        {
            $encoders = [new JsonEncoder()];
            $normalizers = [new ObjectNormalizer()];

            //--->start update
            //This modification represents a solution to this problem:
            //A circular reference has been detected when serializing the object of class "Proxies\__CG__\App\Entity\NameEntity" (configured limit: 1).
//            $defaultContext = [
//                AbstractNormalizer::CIRCULAR_REFERENCE_HANDLER => function ($object, $format, $context) {
//                    return $object->getId();
//                },
//            ];
//            $normalizers = [new ObjectNormalizer(null, null, null, null, null, null, $defaultContext)];
            //end update -------->

            $this->serializer = new Serializer($normalizers, $encoders);
            $result = $this->serializer->serialize($result, "json", [
                'enable_max_depth' => true]);
            $response = new jsonResponse(["status_code" => $status[1],
                    "msg" => $status[0] . " " . "Successfully.",
                    "Data" => json_decode($result)
                ]
                , Response::HTTP_OK);
            $response->headers->set('Access-Control-Allow-Headers', 'X-Header-One,X-Header-Two');
            $response->headers->set('Access-Control-Allow-Origin', '*');
            $response->headers->set('Access-Control-Allow-Methods', 'PUT');
            return $response;
        }      
        else
        {
            $response = new JsonResponse(["status_code"=>"200",
                 "msg"=>"Data not found!"],
             Response::HTTP_OK);

            return $response;
        }
    }
}

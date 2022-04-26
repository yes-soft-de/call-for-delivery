<?php

namespace App\Manager\Eraser;

use App\Constant\Eraser\EraserResultConstant;
use App\Entity\BidOrderEntity;
use App\Entity\PriceOfferEntity;
use App\Manager\Image\ImageManager;
use Doctrine\ORM\EntityManagerInterface;

class EraserManager
{
    private EntityManagerInterface $entityManager;
    private ImageManager $imageManager;

    public function __construct(EntityManagerInterface $entityManager, ImageManager $imageManager)
    {
        $this->entityManager = $entityManager;
        $this->imageManager = $imageManager;
    }

    // delete all bid orders in BidOrderEntity, and their images and prices offers
    public function deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers(): string
    {
        try {
            // first delete all bid orders images
            $images = $this->imageManager->getAllBidOrderImages();

            if (!empty($images)) {
                foreach ($images as $image) {
                    $this->entityManager->remove($image);
                }

                $this->entityManager->flush();
            }

            // second, remove all prices offers
            $this->entityManager->getRepository(PriceOfferEntity::class)->createQueryBuilder('priceOfferEntity')
                ->delete()
                ->getQuery()
                ->getResult();

            // finally remove all bid orders (from BidOrderEntity only)
            $this->entityManager->getRepository(BidOrderEntity::class)->createQueryBuilder('bidOrderEntity')
                ->delete()
                ->getQuery()
                ->getResult();

            return EraserResultConstant::BID_ORDERS_IMAGES_PRICE_OFFERS_DELETE_RESULT;

        } catch (\Exception $e){
            error_log($e);
        }
    }
}

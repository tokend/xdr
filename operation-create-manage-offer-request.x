%#include "xdr/reviewable-request-manage-offer.h"

namespace stellar 
{
struct CreateManageOfferRequestOp
{
    ManageOfferRequest request;

    uint32* allTasks;

    EmptyExt ext;
};

enum CreateManageOfferRequestResultCode 
{
    SUCCESS = 0,

    INVALID_OFFER = -1
};

struct CreateManagerOfferRequestSuccessResult 
{
    uint64 requestID;

    EmptyExt ext;
};

union CreateManageOfferRequestResult switch (CreateManageOfferRequestResultCode code) 
{
case SUCCESS:
    CreateManagerOfferRequestSuccessResult success;
case INVALID_OFFER:
    ManageOfferResultCode validationCode;
default: 
    void;
};

}
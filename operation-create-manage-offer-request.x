%#include "xdr/reviewable-request-manage-offer.h"
%#include "xdr/operation-manage-offer.h"

namespace stellar 
{
struct CreateManageOfferRequestOp
{
    //: ManageOfferRequest details    
    ManageOfferRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for CreateSale request to be approved, which will be used by key sale_create_tasks:<asset_code>
    //: instead of key-value
    uint32* allTasks;

    //: reserved for future extension
    EmptyExt ext;
};

enum CreateManageOfferRequestResultCode 
{
    //: CreateManageOfferRequestOp was successfully applied
    SUCCESS = 0,

    //: Offer is invalid
    INVALID_OFFER = -1,
    //: Tasks for the manage offer request were neither provided in the request nor loaded through KeyValue
    MANAGE_OFFER_TASKS_NOT_FOUND = -2,
    //: Creator details are not in a valid JSON format
    INVALID_CREATOR_DETAILS = -3
};

struct CreateManagerOfferRequestSuccessResult 
{
    //: ID of the ManageOfferRequest
    uint64 requestID;
    //: Indicates whether or not the manage offer request was auto approved    
    bool fulfilled;

    //: Result of manage offer application
    ManageOfferResult* manageOfferResult;

    //: Reserved for future extension
    EmptyExt ext;
};

union CreateManageOfferRequestResult switch (CreateManageOfferRequestResultCode code) 
{
case SUCCESS:
    CreateManagerOfferRequestSuccessResult success;
case INVALID_OFFER:
    ManageOfferResultCode manageOfferCode;
default: 
    void;
};

}
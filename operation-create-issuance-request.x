

%#include "xdr/ledger-entries.h"

namespace stellar
{


/* CreateIssuanceRequestOp

  Creates new issuance request

  Threshold: high

  Result: CreateIssuanceRequestResult
*/
//: CreateIssuanceRequestOp is used to create a reviewable request that, after reviewer's approval,
//: will issue the specified amount of asset to a receiver's balance
struct CreateIssuanceRequestOp
{
    //: Issuance request to create
    IssuanceRequest request;
    //: Reference of the request
    string64 reference;
    //: (optional) Bit mask whose flags must be cleared in order for IssuanceRequest to be approved, which will be used by key issuance_tasks:<asset_code>
    //: instead of key-value
    uint32* allTasks;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateIssuanceRequest Result ********/
//: Result codes of the CreateIssuanceRequestOp
enum CreateIssuanceRequestResultCode
{
    // codes considered as "success" for the operation
    //: CreateIssuanceRequest operation application was successful
    SUCCESS = 0,
    
    // codes considered as "failure" for the operation
    //: Asset to issue is not found
    ASSET_NOT_FOUND = -1,
    //: Trying to create an issuance request with negative/zero amount
    INVALID_AMOUNT = -2,
    //: Request with the same reference already exists
    REFERENCE_DUPLICATION = -3,
    //: Either the target balance is not found or there is a mismatch between the target balance asset and an asset in the request 
    NO_COUNTERPARTY = -4,
    //: Source of operation is not an owner of the asset 
    NOT_AUTHORIZED = -5,
    //: Issued amount plus amount to issue will exceed max issuance amount
    EXCEEDS_MAX_ISSUANCE_AMOUNT = -6,
    //: Amount to issue plus amount on balance would exceed UINT64_MAX 
    RECEIVER_FULL_LINE = -7,
    //: Creator details are not valid JSON
    INVALID_CREATOR_DETAILS = -8,
    //: Fee is greater than the amount to issue
    FEE_EXCEEDS_AMOUNT = -9,
    //: Deprecated
    REQUIRES_KYC = -10,
    //: Deprecated
    REQUIRES_VERIFICATION = -11, //asset requires receiver to be verified
    //: Issuance tasks are not set in the system (i.e. performing issuance is not allowed)
    ISSUANCE_TASKS_NOT_FOUND = -12,
    //: It is not allowed to set system tasks: 1, 2, 4
    SYSTEM_TASKS_NOT_ALLOWED = -13,
    //: Amount precision and asset precision are mismatched
    INVALID_AMOUNT_PRECISION = -14
};

//:Result of successful application of CreateIssuanceRequest operation
struct CreateIssuanceRequestSuccess {
    //: ID of a newly created issuance request
    uint64 requestID;
    //: Account address of the receiver
    AccountID receiver;
    //: Indicates whether or not the Issuance request was auto approved and fulfilled
    bool fulfilled;
    //: Paid fee
    Fee fee;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: Create issuance request result with result code
union CreateIssuanceRequestResult switch (CreateIssuanceRequestResultCode code)
{
case SUCCESS:
    CreateIssuanceRequestSuccess success;
default:
    void;
};
}


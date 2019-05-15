%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap.h"

namespace stellar
{

//: CreateAtomicSwapRequestOp is used to create `CREATE_ATOMIC_SWAP` request
struct CreateAtomicSwapRequestOp
{
    //: Body of request which will be created
    AtomicSwapRequest request;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CreateAtomicSwapRequestOp
enum CreateAtomicSwapRequestResultCode
{
    //: request was successfully created
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Not allowed to create `CREATE_ATOMIC_SWAP` request with zero base amount
    INVALID_BASE_AMOUNT = -1,
    //: Not allowed to pass invalid quote asset code
    INVALID_QUOTE_ASSET = -2,
    //: There is no atomic swap bid with such id
    BID_NOT_FOUND = -3,
    //: There is no quote asset with such code
    QUOTE_ASSET_NOT_FOUND = -4,
    //: Not allowed to create `CREATE_ATOMIC_SWAP` request with amount which exceeds available amount of atomic swap bid
    BID_UNDERFUNDED = -5, // bid has not enough base amount available for lock
    //: There is no key-value entry by `atomic_swap_tasks` key in the system;
    //: configuration does not allow create `CREATE_ATOMIC_SWAP` request
    ATOMIC_SWAP_TASKS_NOT_FOUND = -6,
    //: Base amount precision and asset precision are mismatched
    INCORRECT_PRECISION = -7,
    //: Not allowed to create `CREATE_ATOMIC_SWAP` request for atomic swap bid which is marked as `canceled`
    BID_IS_CANCELLED = -8,
    //: Not allowed to create `CREATE_ATOMIC_SWAP` request for own atomic swap bid
    CANNOT_CREATE_ASWAP_REQUEST_FOR_OWN_BID = -9,
    //: 0 value is received from key value entry by `atomic_swap_tasks` key
    ATOMIC_SWAP_ZERO_TASKS_NOT_ALLOWED = -10
};

//: Success request of CreateASwapRequestOp application
struct CreateAtomicSwapRequestSuccess
{
    //: id of created request
    uint64 requestID;
    //: id of bid owner
    AccountID bidOwnerID;
    //: amount in quote asset which required for request applying
    uint64 quoteAmount;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CreateASwapRequestOp application
union CreateAtomicSwapRequestResult switch (CreateAtomicSwapRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CreateAtomicSwapRequestSuccess success;
default:
    void;
};

}
%#include "xdr/ledger-entries.h"
%#include "xdr/reviewable-request-atomic-swap-bid.h"

namespace stellar
{

//: CreateAtomicSwapBidRequestOp is used to create `CREATE_ATOMIC_SWAP_BID` request
struct CreateAtomicSwapBidRequestOp
{
    //: Body of request which will be created
    CreateAtomicSwapBidRequest request;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CreateAtomicSwapBidRequestOp
enum CreateAtomicSwapBidRequestResultCode
{
    //: request was successfully created
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Not allowed to create `CREATE_ATOMIC_SWAP` request with zero base amount
    INVALID_BASE_AMOUNT = -1,
    //: Not allowed to pass invalid quote asset code
    INVALID_QUOTE_ASSET = -2,
    //: There is no atomic swap bid with such id
    ASK_NOT_FOUND = -3,
    //: There is no quote asset with such code
    QUOTE_ASSET_NOT_FOUND = -4,
    //: Not allowed to create `CREATE_ATOMIC_SWAP_BID` request with amount which exceeds available amount of atomic swap ask
    ASK_UNDERFUNDED = -5, // ask has not enough base amount available for lock
    //: There is no key-value entry by `atomic_swap_bid_tasks` key in the system;
    //: configuration does not allow create `CREATE_ATOMIC_SWAP_BID` request
    ATOMIC_SWAP_BID_TASKS_NOT_FOUND = -6,
    //: Base amount precision and asset precision are mismatched
    INCORRECT_PRECISION = -7,
    //: Not allowed to create `CREATE_ATOMIC_SWAP_BID` request for atomic swap ask which is marked as `canceled`
    ASK_IS_CANCELLED = -8,
    //: Not allowed to create `CREATE_ATOMIC_SWAP_BID` request for own atomic swap ask
    SOURCE_ACCOUNT_EQUALS_ASK_OWNER = -9,
    //: 0 value is received from key value entry by `atomic_swap_bid_tasks` key
    ATOMIC_SWAP_BID_ZERO_TASKS_NOT_ALLOWED = -10,
    //: Not allowed to create atomic swap ask in which product of `baseAmount` and price of the `quoteAsset` exceeds MAX_INT64 value
    QUOTE_AMOUNT_OVERFLOWS = -11
};

//: Success request of CreateAtomicSwapBidRequestOp application
struct CreateAtomicSwapBidRequestSuccess
{
    //: id of created request
    uint64 requestID;
    //: id of ask owner
    AccountID askOwnerID;
    //: amount in quote asset which required for request applying
    uint64 quoteAmount;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CreateAtomicSwapBidRequestOp application
union CreateAtomicSwapBidRequestResult switch (CreateAtomicSwapBidRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CreateAtomicSwapBidRequestSuccess success;
default:
    void;
};

}
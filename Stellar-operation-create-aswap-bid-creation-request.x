%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap-bid.h"

namespace stellar
{

//: CreateASwapBidCreationRequestOp is used to create `CREATE_ATOMIC_SWAP_BID` request
struct CreateASwapBidCreationRequestOp
{
    //: Body of request which will be created
    ASwapBidCreationRequest request;

    //: (optional) Bit mask whose flags must be cleared in order for `CREATE_ATOMIC_SWAP_BID` request to be approved,
    //: which will be used instead of key-value by `atomic_swap_bid_tasks` key
    uint32* allTasks;
    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of CreateASwapBidCreationRequestOp
enum CreateASwapBidCreationRequestResultCode
{
    //: `CREATE_ATOMIC_SWAP_BID` request has either been successfully created
    //: or auto approved
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Not allowed to create atomic swap bid with zero amount
    INVALID_AMOUNT = -1, // amount is equal to 0
    //: Not allowed to create atomic swap bid with quote asset price equals zero
    INVALID_PRICE = -2, // price is equal to 0
    //: Not allowed to create atomic swap bid with json invalid details
    INVALID_DETAILS = -3,
    //: Not allowed to create atomic swap bid in which product of `baseAmount` and price of one `quoteAsset` exceeds MAX_INT64 value
    ATOMIC_SWAP_BID_OVERFLOW = -4,
    //: There is no asset with such code
    BASE_ASSET_NOT_FOUND = -5, // base asset does not exist
    //: Not allowed to use asset as base asset for atomic swap bid which has not `CAN_BE_BASE_IN_ATOMIC_SWAP` policy
    BASE_ASSET_CANNOT_BE_SWAPPED = -6,
    //: There is no asset with such code
    QUOTE_ASSET_NOT_FOUND = -7, // quote asset does not exist
    //: Not allowed to use asset as base asset for atomic swap bid which has not `CAN_BE_QUOTE_IN_ATOMIC_SWAP` policy
    QUOTE_ASSET_CANNOT_BE_SWAPPED = -8,
    //: There is no balance with such id and source account as owner
    BASE_BALANCE_NOT_FOUND = -9,
    //: Not allowed to create atomic swap bid in which base and quote assets are the same
    ASSETS_ARE_EQUAL = -10, // base and quote assets are the same
    //: There is not enough amount on `baseBalance` or `baseAmount` precision does not fit asset precision
    BASE_BALANCE_UNDERFUNDED = -11,
    //: Not allowed to pass invalid or duplicated quote asset codes
    INVALID_QUOTE_ASSET = -12, // one of the quote assets is invalid
    //: There is no key-value entry by `atomic_swap_bid_tasks` key in the system;
    //: configuration does not allow create atomic swap bids
    ATOMIC_SWAP_BID_TASKS_NOT_FOUND = -13
};

//: Success result of CreateASwapBidCreationRequestOp application
struct CreateASwapBidCreationRequestSuccess
{
    //: id of created request
    uint64 requestID;
    //: Indicates whether or not the `CREATE_ATOMIC_SWAP_BID` request was auto approved and fulfilled
    bool fulfilled;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CreateASwapBidCreationRequestOp application
union CreateASwapBidCreationRequestResult switch (CreateASwapBidCreationRequestResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CreateASwapBidCreationRequestSuccess success;
default:
    void;
};

}
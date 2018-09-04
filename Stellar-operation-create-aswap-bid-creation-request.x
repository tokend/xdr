%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap-bid.h"

namespace stellar
{

/* Create atomic swap bid creation request

    Creates atomic swap bid creation request

    Threshold: high

    Result: CreateASwapBidCreationRequestResult
*/

struct CreateASwapBidCreationRequestOp
{
    ASwapBidCreationRequest request;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum CreateASwapBidCreationRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // atomic swap bid does not exist
    INVALID_AMOUNT = -2, // amount is equal to 0
    INVALID_PRICE = -3, // price is equal to 0
    INVALID_DETAILS = -4,
    ATOMIC_SWAP_BID_OVERFLOW = -5,
    BASE_ASSET_NOT_FOUND = -6, // base asset does not exist
    QUOTE_ASSET_NOT_FOUND = -7, // quote asset does not exist
    BASE_ASSET_CANNOT_BE_SWAPPED = -8,
    QUOTE_ASSET_CANNOT_BE_SWAPPED = -9,
    BASE_BALANCE_NOT_FOUND = -10,
    ASSETS_ARE_EQUAL = -11, // base and quote assets are the same
    BASE_BALANCE_UNDERFUNDED = -12,
    INSUFFICIENT_FEE = -13,
    INVALID_QUOTE_ASSET = -14 // one of the quote assets is invalid
};

struct CreateASwapBidCreationRequestSuccess
{
    uint64 requestID;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union CreateASwapBidCreationRequestResult switch (CreateASwapBidCreationRequestResultCode code)
{
case SUCCESS:
    CreateASwapBidCreationRequestSuccess success;
default:
    void;
};

}
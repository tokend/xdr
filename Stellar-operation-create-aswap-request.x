%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap.h"

namespace stellar
{

/* Create atomic swap request

    Creates atomic swap request

    Threshold: high

    Result: CreateASwapRequestResult
*/

struct CreateASwapRequestOp
{
    ASwapRequest request;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum CreateASwapRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVALID_BASE_AMOUNT = -1,
    INVALID_QUOTE_ASSET = -2,
    BID_NOT_FOUND = -3,
    QUOTE_ASSET_NOT_FOUND = -4,
    BID_UNDERFUNDED = -5, // bid has not enough base amount available for lock
    ATOMIC_SWAP_TASKS_NOT_FOUND = -6,
    NOT_ALLOWED_BY_ASSET_POLICY = -7,
    BID_IS_CANCELLED = -8,
    CANNOT_CREATE_ASWAP_REQUEST_FOR_OWN_BID = -9,
    //: 0 value is received from key value entry by `atomic_swap_tasks` key
    ATOMIC_SWAP_ZERO_TASKS_NOT_ALLOWED = -10,
    //: Base amount precision and asset precision set in the system are mismatched
    INCORRECT_PRECISION = -11
};

struct CreateASwapRequestSuccess
{
    uint64 requestID;
    AccountID bidOwnerID;
    uint64 quoteAmount;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union CreateASwapRequestResult switch (CreateASwapRequestResultCode code)
{
case SUCCESS:
    CreateASwapRequestSuccess success;
default:
    void;
};

}
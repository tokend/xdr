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
    SUCCESS = 0
};

struct CreateASwapRequestSuccess
{
    uint64 requestID;

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
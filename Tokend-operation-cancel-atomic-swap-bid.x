%#include "xdr/Tokend-ledger-entries.h"

namespace stellar
{

/* Cancels an atomic swap bid

Threshold: high

Result: CancelASwapBidResult

*/

struct CancelASwapBidOp
{
    uint64 bidID;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

enum CancelASwapBidResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // atomic swap bid does not exist
    ALREADY_CANCELLED = -2 // atomic swap bid already cancelled
};

struct CancelASwapBidResultSuccess
{
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

union CancelASwapBidResult switch (CancelASwapBidResultCode code)
{
case SUCCESS:
    CancelASwapBidResultSuccess success;
default:
    void;
};

}
%#include "xdr/ledger-entries.h"

namespace stellar
{

//: CancelAtomicSwapAskOp is used to cancel existing atomic swap ask
struct CancelAtomicSwapAskOp
{
    //: id of existing atomic swap ask
    uint64 askID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CancelAtomicSwapAskOp
enum CancelAtomicSwapAskResultCode
{
    //: Atomic swap ask was successfully removed or marked as canceled
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no atomic swap ask with such id
    NOT_FOUND = -1, // atomic swap bid does not exist
    //: Not allowed to mark canceled atomic swap ask as canceled
    ALREADY_CANCELLED = -2 // atomic swap ask already cancelled
};

//: Success result of CancelASwapAskOp application
struct CancelAtomicSwapAskResultSuccess
{
    //: Sum of `CREATE_ATOMIC_SWAP_BID` requests' base amounts which are waiting for applying.
    //: Zero means that ask successfully removed
    uint64 lockedAmount;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CancelASwapAskOp application
union CancelAtomicSwapAskResult switch (CancelAtomicSwapAskResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CancelAtomicSwapAskResultSuccess success;
default:
    void;
};

}
%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

//: CancelASwapBidOp is used to cancel existing atomic swap bid
struct CancelASwapBidOp
{
    //: id of existing atomic swap bid
    uint64 bidID;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result codes of CancelASwapBidOp
enum CancelASwapBidResultCode
{
    //: Atomic swap bid was successfully removed or marked as canceled
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: There is no atomic swap bid with such id
    NOT_FOUND = -1, // atomic swap bid does not exist
    //: Not allowed to mark canceled atomic swap bid as canceled
    ALREADY_CANCELLED = -2 // atomic swap bid already cancelled
};

//: Success result of CancelASwapBidOp application
struct CancelASwapBidResultSuccess
{
    //: Sum of `CREATE_ATOMIC_SWAP` requests' base amounts which are waiting for applying.
    //: Zero means that bid successfully removed
    uint64 lockedAmount;

    //: reserved for the future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: Result of CancelASwapBidOp application
union CancelASwapBidResult switch (CancelASwapBidResultCode code)
{
case SUCCESS:
    //: is used to pass useful fields after successful operation applying
    CancelASwapBidResultSuccess success;
default:
    void;
};

}
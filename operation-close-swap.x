%#include "xdr/types.h"

namespace stellar
{

struct CloseSwapOp
{
    //: ID of the swap to close
    uint64 swapID;
    //: (optional) Secret of the swap. Must be provided in order for destination of the swap to receive funds
    Hash* secret;

    //: reserved for future extension
    EmptyExt ext;
};

/******* CloseSwapResult Result ********/

enum CloseSwapResultCode
{
    //: CloseSwap was successful 
    SUCCESS = 0,
    //: Too late to close swap
    SWAP_EXPIRED = -1,
    //: Provided secret is invalid
    INVALID_SECRET = -2,
    //: After the swap fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -3,
    //: Source account is not authorized to close swap
    NOT_AUTHORIZED = -4
};

enum CloseSwapEffect
{
    //: Swap closed
    CLOSED = 0,
    //: Swap cancelled
    CANCELLED = 1
};

//: CloseSwapSuccess is used to pass saved ledger hash and license hash
struct CloseSwapSuccess {
    //: Effect of CloseSwap application
    CloseSwapEffect effect;

    EmptyExt ext;
};

//: CloseSwapResult is a result of CloseSwap operation application
union CloseSwapResult switch (CloseSwapResultCode code)
{
case SUCCESS:
    CloseSwapSuccess success;
default:
    void;
};
}


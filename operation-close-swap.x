%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{

struct CloseSwapOp
{
    uint64 swapID;

    Hash* secret;

    //: reserved for future extension
    EmptyExt ext;
};

/******* CloseSwapResult Result ********/

enum CloseSwapResultCode
{
    //: CloseSwap was successful 
    SUCCESS = 0,

    SWAP_EXPIRED = -1,
    INVALID_SECRET = -2,
    //: After the swap fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -3

};
//: CloseSwapSuccess is used to pass saved ledger hash and license hash
struct CloseSwapSuccess {
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


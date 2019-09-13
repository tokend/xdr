%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{

struct CloseSwapOp
{
    uint64 swapID;

    Hash secret;

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
    LINE_FULL = -3,
    //: Stats entry exceeded account limits
    STATS_OVERFLOW = -7,
    //: Account will exceed its limits after the payment is fulfilled
    LIMITS_EXCEEDED = -8,

};
//: CloseSwapSuccess is used to pass saved ledger hash and license hash
struct CloseSwapSuccess {
    //: ID of the destination account
    AccountID destination;
    //: ID of the destination balance
    BalanceID destinationBalanceID;

    //: Unique ID of the swap
    uint64 swapID;
    //: Secret used in swap
    Hash secret;

    //: Code of an asset used in swap
    AssetCode asset;
    //: Amount sent by the sender
    uint64 amount;

    //: Fee charged from the source balance
    Fee actualSourceFee;
    //: Fee charged from the destination balance
    Fee actualDestinationFee;

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


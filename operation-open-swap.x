%#include "xdr/types.h"
%#include "xdr/operation-payment.h"

namespace stellar
{

struct OpenSwapOp
{
    //: Source balance of the swap
    BalanceID sourceBalance;
    //: Amount to send in swap
    uint64 amount;

   //: `destination` defines the type of instance that receives amount based on given PaymentDestinationType
   union switch (PaymentDestinationType type) {
       case ACCOUNT:
           AccountID accountID;
       case BALANCE:
           BalanceID balanceID;
   } destination;

    //: Fee data for the swap
    PaymentFeeData feeData;
    //: Arbitrary stringified json object provided by swap source
    longstring details;

    //: Hash of the secret
    Hash secretHash;
    //: Time till which swapped funds can be received by destination if valid secret is provided
    int64 lockTime;

    //: reserved for future extension
    EmptyExt ext;
};

/******* OpenSwapResult Result ********/

enum OpenSwapResultCode
{
    //: OpenSwap was successful 
    SUCCESS = 0,

    //: Source and destination balances are the same
    MALFORMED = -1,
    //: Not enough funds in the source account
    UNDERFUNDED = -2,
    //: There is no balance found with an ID provided in `destinations.balanceID`
    //: Sender balance asset and receiver balance asset are not equal
    BALANCE_ASSETS_MISMATCHED = -3,
    //: There is no balance found with ID provided in `sourceBalanceID`
    SRC_BALANCE_NOT_FOUND = -4,
    //: Payment asset does not have a `SWAPPABLE` policy set
    NOT_ALLOWED_BY_ASSET_POLICY = -5,
    //: Overflow during total fee calculation
    INVALID_DESTINATION_FEE = -6,
    //: Payment fee amount is insufficient
    INSUFFICIENT_FEE_AMOUNT = -7,
    //: Fee charged from destination balance is greater than the amount
    AMOUNT_IS_LESS_THAN_DEST_FEE = -8,
    //: There is no account found with an ID provided in `destination.accountID`
    //: Amount precision and asset precision are mismatched
    INCORRECT_AMOUNT_PRECISION = -9,
    //: Not allowed to create swap with invalid json details
    INVALID_DETAILS = -10,
    //: Lock time is in the past
    INVALID_LOCK_TIME = -11,
    //: Zero amount is not allowed
    INVALID_AMOUNT = -12

};
//: OpenSwapSuccess is used to pass saved ledger hash and license hash
struct OpenSwapSuccess {
    uint64 swapID;

    //: ID of the destination account
    AccountID destination;
    //: ID of the destination balance
    BalanceID destinationBalance;

    //: Code of an asset used in swap
    AssetCode asset;

    //: Fee to be charged from the source balance
    Fee actualSourceFee;
    //: Fee to be charged from the destination balance
    Fee actualDestinationFee;

    //: reserved for future extension
    EmptyExt ext;
};

//: OpenSwapResult is a result of OpenSwap operation application
union OpenSwapResult switch (OpenSwapResultCode code)
{
case SUCCESS:
    OpenSwapSuccess success;
default:
    void;
};
}


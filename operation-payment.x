%#include "xdr/types.h"

namespace stellar
{

/* Payment

    Send an amount in specified asset to a destination account.

    Threshold: med

    Result: PaymentResult
*/

struct PaymentFeeData {
    //: Fee to pay by source balance
    Fee sourceFee;
    //: Fee kept from destination account/balance
    Fee destinationFee;
    //: Indicates whether or not the source of payment pays the destination fee
    bool sourcePaysForDest;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Defines the type of destination of the payment
enum PaymentDestinationType {
    ACCOUNT = 0,
    BALANCE = 1
};

//: PaymentOp is used to transfer some amount of asset from the source balance to destination account/balance
struct PaymentOp
{
    //: ID of the source balance of payment
    BalanceID sourceBalanceID;

    //: `destination` defines the type of instance that receives the payment based on given PaymentDestinationType
    union switch (PaymentDestinationType type) {
        case ACCOUNT:
            AccountID accountID;
        case BALANCE:
            BalanceID balanceID;
    } destination;

    //: Amount of payment
    uint64 amount;

    //: `feeData` defines all data about the payment fee
    PaymentFeeData feeData;

    //: `subject` is a user-provided info about the real-life purpose of payment
    longstring subject;
    //: `reference` is a string formed by a payment sender. `Reference-sender account` pair is unique.
    longstring reference;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum PaymentResultCode
{
    // codes considered as "success" for the operation
    //: Payment was successfully completed
    SUCCESS = 0, // payment successfully completed

    // codes considered as "failure" for the operation
    //: Payment sender balance ID and payment receiver balance ID are equal or reference is longer than 64 symbols
    MALFORMED = -1,
    //: Not enough funds in the source account
    UNDERFUNDED = -2,
    //: After the payment fulfillment, the destination balance will exceed the limit (total amount on the balance will be greater than UINT64_MAX)
    LINE_FULL = -3,
    //: There is no balance found with an ID provided in `destinations.balanceID`
    DESTINATION_BALANCE_NOT_FOUND = -4,
    //: Sender balance asset and receiver balance asset are not equal
    BALANCE_ASSETS_MISMATCHED = -5,
    //: There is no balance found with ID provided in `sourceBalanceID`
    SRC_BALANCE_NOT_FOUND = -6,
    //: Pair `reference-sender account` of the payment is not unique
    REFERENCE_DUPLICATION = -7,
    //: Stats entry exceeded account limits
    STATS_OVERFLOW = -8,
    //: Account will exceed its limits after the payment is fulfilled
    LIMITS_EXCEEDED = -9,
    //: Payment asset does not have a `TRANSFERABLE` policy set
    NOT_ALLOWED_BY_ASSET_POLICY = -10,
    //: Overflow during total fee calculation
    INVALID_DESTINATION_FEE = -11,
    //: Payment fee amount is insufficient
    INSUFFICIENT_FEE_AMOUNT = -12,
    //: Fee charged from destination balance is greater than the payment amount
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -13,
    //: There is no account found with an ID provided in `destination.accountID`
    DESTINATION_ACCOUNT_NOT_FOUND = -14,
    //: Amount precision and asset precision are mismatched
    INCORRECT_AMOUNT_PRECISION = -15,
    //: Too much signs in subject
    INVALID_SUBJECT = -16
};

//: `PaymentResponse` defines the response on the corresponding PaymentOp
struct PaymentResponse {
    //: ID of the destination account
    AccountID destination;
    //: ID of the destination balance
    BalanceID destinationBalanceID;

    //: Code of an asset used in payment
    AssetCode asset;
    //: Amount sent by the sender
    uint64 sourceSentUniversal;
    //: Unique ID of the payment
    uint64 paymentID;

    //: Fee charged from the source balance
    Fee actualSourcePaymentFee;
    //: Fee charged from the destination balance
    Fee actualDestinationPaymentFee;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PaymentResult switch (PaymentResultCode code)
{
case SUCCESS:
    PaymentResponse paymentResponse;
default:
    void;
};

}
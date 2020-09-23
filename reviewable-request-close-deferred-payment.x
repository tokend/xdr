

%#include "xdr/types.h"
%#include "xdr/operation-payment.h"


namespace stellar
{

//: Defines the type of destination of the payment
enum CloseDeferredPaymentDestinationType {
    ACCOUNT = 0,
    BALANCE = 1
};

struct CloseDeferredPaymentRequest {
    uint64 deferredPaymentID;

    //: `destination` defines the type of instance that receives the payment based on given PaymentDestinationType
    union switch (CloseDeferredPaymentDestinationType type) {
        case ACCOUNT:
            AccountID accountID;
        case BALANCE:
            BalanceID balanceID;
    } destination;

    //: Arbitrary stringified json object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester

    uint64 amount;

    uint32 sequenceNumber;

    EmptyExt ext;
};

}

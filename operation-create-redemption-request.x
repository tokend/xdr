%#include "xdr/reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateRedemptionRequestOp

    Creates redemption request

    Threshold: high

    Result: CreateRedemptionRequestResult
*/
//: CreateRedemptionRequest operation creates a reviewable request
//: that will transfer the specified amount from current holder's balance to destination balance after the reviewer's approval
struct CreateRedemptionRequestOp
{
    //: Reference of RedemptionRequest
    string64 reference; // TODO longstring ?
    //: Parameters of RedemptionRequest
    RedemptionRequest redemptionRequest;
    //: (optional) Bit mask whose flags must be cleared in order for RedemptionRequest to be approved, which will be used by key redemption_tasks
    //: instead of key-value
    uint32* allTasks;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};


%#include "xdr/types.h"

namespace stellar
{
//: Body of reviewable `LimitsUpdateRequest` contains details regarding limit updates
struct LimitsUpdateRequest
{
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
%#include "xdr/operation-manage-offer.h"

namespace stellar 
{

struct ManageOfferRequest 
{
    ManageOfferOp op;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case MOVEMENT_REQUESTS_DETAILS:
        longstring creatorDetails;
    } ext;
};
}
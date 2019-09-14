%#include "xdr/operation-manage-offer.h"

namespace stellar 
{

struct ManageOfferRequest 
{
    ManageOfferOp op;

    EmptyExt ext;
};
}
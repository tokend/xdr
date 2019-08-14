
%#include "xdr/types.h"

namespace stellar
{

struct IdentifierConfirmationEntry
{
    uint64 id;

    uint64 identifierID;

    AccountID registrar;

    EmptyExt ext;
};

}
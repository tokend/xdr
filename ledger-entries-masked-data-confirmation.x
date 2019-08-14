
%#include "xdr/types.h"

namespace stellar
{

struct MaskedDataConfirmationEntry
{
    uint64 id;

    uint64 dataID;

    uint64 mask;

    AccountID registrar;

    EmptyExt ext;
};

}
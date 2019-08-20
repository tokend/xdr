
%#include "xdr/types.h"

namespace stellar
{

struct MaskedDataConfirmationEntry
{
    int64 id;

    int64 dataID;

    uint32 mask;

    AccountID registrar;

    EmptyExt ext;
};

}
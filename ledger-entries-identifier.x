%#include "xdr/types.h"

namespace stellar
{

struct IdentifierEntry
{
    uint64 id;

    AccountID accountID;

    longstring value;

    EmptyExt ext;
};

}
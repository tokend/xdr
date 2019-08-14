
%#include "xdr/types.h"

namespace stellar
{

//: `MaskedDataType` defines the type of value in the masked entry
enum MaskedDataType
{
    MAIN = 1,
    ADDITIONAL = 2
};

//: `MaskedDataEntry` is an entry used to store masked data
struct MaskedDataEntry
{
    uint64 id;

    AccountID accountID;

    MaskedDataType type;

    longstring value;

    EmptyExt ext;
};

}
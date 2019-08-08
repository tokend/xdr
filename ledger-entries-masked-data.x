
%#include "xdr/types.h"

namespace stellar
{

    //: `MaskedDataType` defines the type of value in the masked entry
    enum MaskedDataType
    {
        MAIN = 1,
        ADDITIONAL = 2,
        IDENTIFIER = 3
    };

    struct MaskedData
    {
        longstring value;

        MaskedDataType type;

        EmptyExt ext;
    };

    //: `MaskedDataEntry` is an entry used to store masked data 
    struct MaskedDataEntry
    {
        uint64 id;

        AccountID account;

        MaskedData data;

        EmptyExt ext;
    };

}
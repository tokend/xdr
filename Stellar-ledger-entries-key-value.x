
%#include "xdr/Stellar-types.h"

namespace stellar
{

    enum KeyValueEntryType
    {
        UINT32 = 1
    };

    struct KeyValueEntry
    {
        longstring key;

        union switch (KeyValueEntryType type)
        {
             case UINT32:
                uint32 defaultMask;
        }
        value;

        // reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

}
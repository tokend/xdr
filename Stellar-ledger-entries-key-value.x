
%#include "xdr/Stellar-types.h"

namespace stellar
{

    enum KeyValueEntryType
    {
        UINT32 = 1,
        STRING = 2
    };

    struct KeyValueEntry
    {
        longstring key;

        union switch (KeyValueEntryType type)
        {
             case UINT32:
                uint32 ui32Value;
             case STRING:
                string stringValue<>;
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

%#include "xdr/Stellar-types.h"

namespace stellar
{

    //: `KeyValueEntryType` defines the type of the value in key-value entry
    enum KeyValueEntryType
    {
        UINT32 = 1,
        STRING = 2,
        UINT64 = 3
    };

    //: `KeyValueEntryValue` represents the value based on the given `KeyValueEntryType`
    union KeyValueEntryValue switch (KeyValueEntryType type)
    {
        case UINT32:
            uint32 ui32Value;
        case STRING:
            string stringValue<>;
        case UINT64:
            uint64 ui64Value;
    };

    //: `KeyValueEntry` is an entry that is used to store key mapped values
    struct KeyValueEntry
    {
        //: String value that must be unique among other keys for kev-value pairs
        longstring key;

        //: Value that corresponds to the particular key. Depends on `KeyValueEntryType`
        KeyValueEntryValue value;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };



}
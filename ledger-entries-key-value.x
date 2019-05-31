
%#include "xdr/types.h"

namespace stellar
{

    //: `KeyValueEntryType` defines the type of value in the key-value entry
    enum KeyValueEntryType
    {
        UINT32 = 1,
        STRING = 2,
        UINT64 = 3
    };

    //: `KeyValueEntryValue` represents the value based on given `KeyValueEntryType`
    union KeyValueEntryValue switch (KeyValueEntryType type)
    {
        case UINT32:
            uint32 ui32Value;
        case STRING:
            string stringValue<>;
        case UINT64:
            uint64 ui64Value;
    };

    //: `KeyValueEntry` is an entry used to store key mapped values
    struct KeyValueEntry
    {
        //: String value that must be unique among other keys for kev-value pairs
        longstring key;

        //: Value that corresponds to particular key (depending on `KeyValueEntryType`, 
        //: the value can be either uint32, or uint64, or string)
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
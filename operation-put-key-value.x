%#include "xdr/ledger-entries.h"

namespace stellar
{
    //: `PutKeyValueOp` is used to update the key-value entry present in the system
    struct PutKeyValueOp
    {
        //: `key` is the key for KeyValueEntry
        longstring key;
        KeyValueEntryValue value;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: `PutKeyValueSuccess` represents details returned after the successful application of `PutKeyValueOp`
    struct PutKeyValueSuccess
    {
        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: Result codes for `PutKeyValueOp`
    enum PutKeyValueResultCode
    {
        //: `PutKeyValueOp` is applied successfully
        SUCCESS = 0,
        //: Value type of the key-value entry is forbidden for the provided key
        INVALID_TYPE = -1,
        //: value is forbidden for the provided key
        VALUE_NOT_ALLOWED = -2
    };

    //: `PutKeyValueResult` represents the result of PutKeyValueOp
    union PutKeyValueResult switch (PutKeyValueResultCode code)
    {
        case SUCCESS:
            PutKeyValueSuccess success;
        default:
            void;
    };


}
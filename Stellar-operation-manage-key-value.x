%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{
    //: Actions that could be performed on KeyValueEntry
    enum ManageKVAction
    {
        PUT = 1,
        REMOVE = 2
    };

    //: `ManageKeyValueOp` is used to create manage key-value operation which on successful application will update the key-value entry presented in the system
    struct ManageKeyValueOp
    {
        //: `key` is the key for KeyValueEntry
        longstring key;
        //: `action` defines an action applied to the KeyValue based on the given ManageKVAction
        union switch(ManageKVAction action)
        {
            case PUT:
                 //: Value to store
                 KeyValueEntryValue value;
            case REMOVE:
                void;
        }
        action;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: `ManageKeyValueSuccess` represents the details returned after successful application of `ManageKeyValueOp`
    struct ManageKeyValueSuccess
    {
        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: Result codes for `ManageKeyValueOp`
    enum ManageKeyValueResultCode
    {
        //: `ManageKeyValueOp` successfully applied
        SUCCESS = 0,
        //: There is no key value with such key
        NOT_FOUND = -1,
        //: Value of the key-value entry has invalid type
        INVALID_TYPE = -2,
        //: uint32 zero value is not allowed
        ZERO_VALUE_NOT_ALLOWED = -3
    };

    //: `ManageKeyValueResult` represents the result of ManageKeyValueOp
    union ManageKeyValueResult switch (ManageKeyValueResultCode code)
    {
        case SUCCESS:
            ManageKeyValueSuccess success;
        default:
            void;
    };


}
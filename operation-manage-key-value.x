%#include "xdr/ledger-entries.h"

namespace stellar
{
    //: Actions that can be performed on `KeyValueEntry`
    enum ManageKVAction
    {
        PUT = 1,
        REMOVE = 2
    };

    //: `ManageKeyValueOp` is used to create the manage key-value operation which, if applied successfully, will update the key-value entry present in the system
    struct ManageKeyValueOp
    {
        //: `key` is the key for KeyValueEntry
        longstring key;
        //: `action` defines an action applied to the KeyValue based on given ManageKVAction
        //: * Action `PUT` stores new value for a particular key
        //: * Action `REMOVE` removes the value by a particular key
        union switch(ManageKVAction action)
        {
            case PUT:
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

    //: `ManageKeyValueSuccess` represents details returned after the successful application of `ManageKeyValueOp`
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
        //: `ManageKeyValueOp` is applied successfully
        SUCCESS = 0,
        //: There is no key value with such key
        NOT_FOUND = -1,
        //: Value type of the key-value entry is forbidden for the provided key
        INVALID_TYPE = -2,
        //: zero value is forbidden for the provided key
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
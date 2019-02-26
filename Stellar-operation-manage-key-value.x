%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{
    //: Actions could be applied to the key-value entry
    enum ManageKVAction
    {
        PUT = 1,
        REMOVE = 2
    };

    //: `ManageKeyValueOp` represents manage key-value operation with the corresponding details
    struct ManageKeyValueOp
    {
        //: `key` is the key for KeyValueEntry
        longstring key;
        //: `action` defines an action applied to the KeyValue based on the given ManageKVAction
        union switch(ManageKVAction action)
        {
            case PUT:
                 //: Value to put
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

    //: `ManageKeyValueSuccess` represents data returned after successful manage key-value operation
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
        //: `ManageKeyValueOp` successfully performed
        SUCCESS = 0,
        //: There is no key value with such key
        NOT_FOUND = -1,
        //: Value type of `kyc_lvlup_rules:<current_account_type>:0:<account_type_to_set>:0` key must be `UINT32`
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
%#include "xdr/ledger-entries.h"

namespace stellar
{

    //: `RemoveKeyValueOp` is used to remove key-value entry present in the system by key
    struct RemoveKeyValueOp
    {
        //: `key` is the key for KeyValueEntry
        longstring key;

        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: `RemoveKeyValueSuccess` represents details returned after the successful application of `RemoveKeyValueOp`
    struct RemoveKeyValueSuccess
    {
        //: reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    //: Result codes for `RemoveKeyValueOp`
    enum RemoveKeyValueResultCode
    {
        //: `RemoveKeyValueOp` is applied successfully
        SUCCESS = 0,
        //: There is no key value with such key
        NOT_FOUND = -1
    };

    //: `RemoveKeyValueResult` represents the result of RemoveKeyValueOp
    union RemoveKeyValueResult switch (RemoveKeyValueResultCode code)
    {
        case SUCCESS:
            RemoveKeyValueSuccess success;
        default:
            void;
    };


}
%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

    enum ManageKVAction
    {
        PUT = 1,
        REMOVE = 2
    };

    struct ManageKeyValueOp
    {
        string256 key;
        union switch(ManageKVAction action)
        {
            case PUT:
                KeyValueEntry value;
            case REMOVE:
                void;
        }
        action;

        // reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    };

    struct ManageKeyValueSuccess
    {
        // reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };

    enum ManageKeyValueResultCode
    {
        SUCCESS = 1,
        NOT_FOUND = -1,
        INVALID_TYPE = -2
    };

    union ManageKeyValueResult switch (ManageKeyValueResultCode code)
    {
        case SUCCESS:
            ManageKeyValueSuccess success;
        default:
            void;
    };

}
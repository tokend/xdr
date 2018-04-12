
%#include "xdr/Stellar-types.h"

namespace stellar
{

    enum KeyValueEntryType
    {
        KYC_SETTINGS = 1
    };

    struct KYCSettings
    {
        // reserved for future use
        union switch (LedgerVersion v)
        {
            case EMPTY_VERSION:
                void;
        }
        ext;
    };


    struct KeyValueEntry
    {
        string256 key;


        union switch (KeyValueEntryType type)
        {
             case KYC_SETTINGS:
                KYCSettings kycSettings;
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
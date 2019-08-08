%#include "xdr/types.h"

namespace stellar
{

/* Entries used to define the bucket list */

union LedgerKey switch (LedgerEntryType type)
{
case ACCOUNT:
    struct
    {
        AccountID accountID;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
       ext;
    } account;
case MASKED_DATA:
    struct {
        uint64 id;

        EmptyExt ext;
    } maskedData;
case RECOVERY:
    struct {
        AccountID target;

        EmptyExt ext;
    } recovery;
};
}
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

        EmptyExt ext;
    } account;
case MASKED_DATA:
    struct {
        int64 id;

        EmptyExt ext;
    } maskedData;
case RECOVERY:
    struct {
        AccountID accountID;

        EmptyExt ext;
    } recovery;
case IDENTIFIER:
    struct
    {
        int64 id;

        EmptyExt ext;
    } identifier;
case IDENTIFIER_CONFIRMATION:
    struct
    {
        int64 id;

        EmptyExt ext;
    } identifierConfirmation;
case MASKED_DATA_CONFIRMATION:
    struct
    {
        int64 id;

        EmptyExt ext;
    } maskedDataConfirmation;
};
}
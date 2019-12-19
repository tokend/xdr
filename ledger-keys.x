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
case SIGNER:
    struct
    {
        PublicKey pubKey;
        AccountID accountID;

        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signer;
case BALANCE:
    struct
    {
        BalanceID balanceID;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } balance;
case ASSET:
    struct
    {
        AssetCode code;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } asset;
case REFERENCE:
    struct
    {
        AccountID sender;
        string64 reference;
        OperationType opType;
        uint32 securityType;

        EmptyExt ext;
    } reference;
case REVIEWABLE_REQUEST:
    struct {
        uint64 requestID;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } reviewableRequest;
case KEY_VALUE:
    struct {
        longstring key;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } keyValue;
case ACCOUNT_KYC:
    struct {
        AccountID accountID;
        union switch(LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountKYC;
case ROLE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } role;
case RULE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } rule;
case DATA:
    struct {
        uint64 id;

        EmptyExt ext;
    } data;

};
}
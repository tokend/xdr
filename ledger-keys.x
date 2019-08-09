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
case ACCOUNT_ROLE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountRole;
case ACCOUNT_RULE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountRule;
case SIGNER_ROLE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signerRole;
case SIGNER_RULE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signerRule;
case STAMP:
    struct {
        Hash ledgerHash;
        Hash licenseHash;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } stamp;
case LICENSE:
    struct {
        Hash licenseHash;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } license;
case DATA:
    struct {
        uint64 id;

        EmptyExt ext;
    } data;
};
}
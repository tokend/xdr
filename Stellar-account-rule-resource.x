%#include "xdr/Stellar-types.h"


namespace stellar
{

union AccountRuleResource switch (LedgerEntryType type)
{
case ASSET:
    struct
    {
        AssetCode assetCode;
        int64 assetType;

        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } asset;
case REVIEWABLE_REQUEST:
    struct
    {
        ReviewableRequestType requestType;

        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } reviewableRequest;
case ANY:
    void;
case ACCOUNT:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } account;
case FEE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } fee;
case BALANCE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } balance;
case REFERENCE_ENTRY:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } reference;
case ASSET_PAIR:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } assetPair;
case OFFER_ENTRY:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } offer;
case EXTERNAL_SYSTEM_ACCOUNT_ID:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } externalSystemAccount;
case SALE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } sale;
case ACCOUNT_KYC:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } accountKYC;
case EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } externalSystemPool;
case KEY_VALUE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } keyValue;
case LIMITS_V2:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } limits;
case STATISTICS_V2:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } statistics;
case PENDING_STATISTICS:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } pendingStatistics;
case ACCOUNT_ROLE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } accountRole;
case ACCOUNT_RULE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } accountRule;
/*case SIGNER_RULE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } signerRule;
case SIGNER_ROLE:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } signerRole;
case SIGNER:
    struct
    {
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } signer;*/
};

}
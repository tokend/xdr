%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SettlementOptionAction
{
    PROLONG = 0,
    REDEEM = 1
};

struct SettlementOptionEntry
{
    uint64 settlementOptionID;
    uint64 investmentTokenSaleID;
    AccountID investorID;

    union switch (SettlementOptionAction action)
    {
    case PROLONG:
        void;
    case REDEEM:
        AssetCode redemptionAsset;
    }
    details;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
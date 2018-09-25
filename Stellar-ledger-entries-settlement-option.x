%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SettlementOptionAction
{
    PROLONG = 0,
    REDEEM = 1
};

union SettlementOptionDetails switch (SettlementOptionAction action)
{
case PROLONG:
    void;
case REDEEM:
    AssetCode redemptionAsset;
};

struct SettlementOptionEntry
{
    uint64 settlementOptionID;
    uint64 investmentTokenSaleID;
    AccountID investorID;

    SettlementOptionDetails details;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
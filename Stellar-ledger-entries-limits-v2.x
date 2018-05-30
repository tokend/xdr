%#include "xdr/Stellar-types.h"

namespace stellar
{

enum StatsOpType
{
    PAYMENT_OUT = 1,
    WITHDRAW = 2,
    SPEND = 3
};

// the idea behind this request is to select all limits which are appliable for account-operation pair
// we should try to select most precise limits (for specific account, for specific type, system global)
// select distinct on (stats_op_type, asset_code, is_convert_needed) * from limits_v2 where
// (account_id = ? or account_id is null) and (account_type = ? or account_type is null) and (asset_code = ? or isConvertNeeded)
// and (stats_op_type in (?, ?)) order by
// stats_op_type, asset_code, is_convert_needed, account_id = ?, account_type = ? desc;
struct LimitsV2Entry
{
    uint64      id;
    AccountType *accountType;
    AccountID   *accountID;
    StatsOpType statsOpType;
    AssetCode   assetCode;
    bool        isConvertNeeded;

    uint64 dailyOut;
    uint64 weeklyOut;
    uint64 monthlyOut;
    uint64 annualOut;

     // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
//
//  static.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 12.07.2022.
//

import Foundation

let developerString = "Victor Varenik"
let versionString = "2.1"
let appstoreUrl = "https://apps.apple.com/ua/app/moneytracker/id1631794003"
let githubUrl = "https://github.com/kotleni/MoneyTracker-ios/"

let currencyList = [
    // default
    "AFN",
    "EUR",
    "ALL",
    "DZD",
    "USD",
    "EUR",
    "AOA",
    "XCD",
    "XCD",
    "ARS",
    "AMD",
    "AWG",
    "AUD",
    "EUR",
    "AZN",
    "BSD",
    "BHD",
    "BDT",
    "BBD",
    "BYN",
    "EUR",
    "BZD",
    "XOF",
    "BMD",
    "INR",
    "BTN",
    "BOB",
    "BOV",
    "BAM",
    "BWP",
    "NOK",
    "BRL",
    "USD",
    "BND",
    "BGN",
    "XOF",
    "BIF",
    "CVE",
    "KHR",
    "XAF",
    "CAD",
    "KYD",
    "XAF",
    "XAF",
    "CLP",
    "CLF",
    "CNY",
    "AUD",
    "AUD",
    "COP",
    "COU",
    "KMF",
    "CDF",
    "XAF",
    "NZD",
    "CRC",
    "XOF",
    "HRK",
    "CUP",
    "CUC",
    "ANG",
    "EUR",
    "CZK",
    "DKK",
    "DJF",
    "XCD",
    "DOP",
    "USD",
    "EGP",
    "SVC",
    "USD",
    "XAF",
    "ERN",
    "EUR",
    "SZL",
    "ETB",
    "EUR",
    "FKP",
    "DKK",
    "FJD",
    "EUR",
    "EUR",
    "EUR",
    "XPF",
    "EUR",
    "XAF",
    "GMD",
    "GEL",
    "EUR",
    "GHS",
    "GIP",
    "EUR",
    "DKK",
    "XCD",
    "EUR",
    "USD",
    "GTQ",
    "GBP",
    "GNF",
    "XOF",
    "GYD",
    "HTG",
    "USD",
    "AUD",
    "EUR",
    "HNL",
    "HKD",
    "HUF",
    "ISK",
    "INR",
    "IDR",
    "XDR",
    "IRR",
    "IQD",
    "EUR",
    "GBP",
    "ILS",
    "EUR",
    "JMD",
    "JPY",
    "GBP",
    "JOD",
    "KZT",
    "KES",
    "AUD",
    "KPW",
    "KRW",
    "KWD",
    "KGS",
    "LAK",
    "EUR",
    "LBP",
    "LSL",
    "ZAR",
    "LRD",
    "LYD",
    "CHF",
    "EUR",
    "EUR",
    "MOP",
    "MKD",
    "MGA",
    "MWK",
    "MYR",
    "MVR",
    "XOF",
    "EUR",
    "USD",
    "EUR",
    "MRU",
    "MUR",
    "EUR",
    "XUA",
    "MXN",
    "MXV",
    "USD",
    "MDL",
    "EUR",
    "MNT",
    "EUR",
    "XCD",
    "MAD",
    "MZN",
    "MMK",
    "NAD",
    "ZAR",
    "AUD",
    "NPR",
    "EUR",
    "XPF",
    "NZD",
    "NIO",
    "XOF",
    "NGN",
    "NZD",
    "AUD",
    "USD",
    "NOK",
    "OMR",
    "PKR",
    "USD",
    "PAB",
    "USD",
    "PGK",
    "PYG",
    "PEN",
    "PHP",
    "NZD",
    "PLN",
    "EUR",
    "USD",
    "QAR",
    "EUR",
    "RON",
    "RUB",
    "RWF",
    "EUR",
    "XCD",
    "XCD",
    "EUR",
    "EUR",
    "XCD",
    "WST",
    "EUR",
    "STN",
    "SAR",
    "XOF",
    "RSD",
    "SCR",
    "SLL",
    "SGD",
    "ANG",
    "XSU",
    "EUR",
    "EUR",
    "SBD",
    "SOS",
    "ZAR",
    "SSP",
    "EUR",
    "LKR",
    "SDG",
    "SRD",
    "NOK",
    "SEK",
    "CHF",
    "CHE",
    "CHW",
    "SYP",
    "TWD",
    "TJS",
    "THB",
    "USD",
    "XOF",
    "NZD",
    "TOP",
    "TTD",
    "TND",
    "TRY",
    "TMT",
    "USD",
    "AUD",
    "UGX",
    "UAH",
    "AED",
    "GBP",
    "USD",
    "USD",
    "USN",
    "UYU",
    "UYI",
    "UYW",
    "UZS",
    "VUV",
    "VES",
    "VND",
    "USD",
    "USD",
    "XPF",
    "MAD",
    "YER",
    "ZMW",
    "ZWL",
    "XBA",
    "XBB",
    "XBC",
    "XBD",
    "XTS",
    "XXX",
    "XAU",
    "XPD",
    "XPT",
    "XAG",
    "AFA",
    "FIM",
    "ALK",
    "ADP",
    "ESP",
    "FRF",
    "AOK",
    "AON",
    "AOR",
    "ARA",
    "ARP",
    "ARY",
    "RUR",
    "ATS",
    "AYM",
    "AZM",
    "RUR",
    "BYB",
    "BYR",
    "RUR",
    "BEC",
    "BEF",
    "BEL",
    "BOP",
    "BAD",
    "BRB",
    "BRC",
    "BRE",
    "BRN",
    "BRR",
    "BGJ",
    "BGK",
    "BGL",
    "BUK",
    "HRD",
    "HRK",
    "CYP",
    "CSJ",
    "CSK",
    "ECS",
    "ECV",
    "GQE",
    "EEK",
    "XEU",
    "FIM",
    "FRF",
    "FRF",
    "FRF",
    "GEK",
    "RUR",
    "DDM",
    "DEM",
    "GHC",
    "GHP",
    "GRD",
    "FRF",
    "GNE",
    "GNS",
    "GWE",
    "GWP",
    "ITL",
    "ISJ",
    "IEP",
    "ILP",
    "ILR",
    "ITL",
    "RUR",
    "RUR",
    "LAJ",
    "LVL",
    "LVR",
    "LSM",
    "ZAL",
    "LTL",
    "LTT",
    "LUC",
    "LUF",
    "LUL",
    "MGF",
    "MWK",
    "MVQ",
    "MLF",
    "MTL",
    "MTP",
    "FRF",
    "MRO",
    "FRF",
    "MXP",
    "FRF",
    "MZE",
    "MZM",
    "NLG",
    "ANG",
    "NIC",
    "PEH",
    "PEI",
    "PEN",
    "PES",
    "PLZ",
    "PTE",
    "FRF",
    "ROK",
    "ROL",
    "RON",
    "RUR",
    "FRF",
    "FRF",
    "FRF",
    "ITL",
    "STD",
    "CSD",
    "EUR",
    "SKK",
    "SIT",
    "ZAL",
    "SDG",
    "RHD",
    "ESA",
    "ESB",
    "ESP",
    "SDD",
    "SDP",
    "SRG",
    "SZL",
    "CHC",
    "RUR",
    "TJR",
    "IDR",
    "TPE",
    "TRL",
    "TRY",
    "RUR",
    "TMM",
    "UGS",
    "UGW",
    "UAK",
    "SUR",
    "USS",
    "UYN",
    "UYP",
    "RUR",
    "VEB",
    "VEF",
    "VEF",
    "VEF",
    "VNC",
    "YUD",
    "YUM",
    "YUN",
    "ZRN",
    "ZRZ",
    "ZMK",
    "ZWC",
    "ZWD",
    "ZWD",
    "ZWN",
    "ZWR",
    "XFO",
    "XRE",
    "XFU",
    
    // crypto
    "BTC",
    "USDT",
    "XMR",
    "ETH",
    "SOL",
    "BCH"
]

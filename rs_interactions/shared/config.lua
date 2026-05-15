Config = {}

Config.DevMode = false -- true or false
Config.Locale = 'en' -- en, de, es

Config.Framework = "vorp"   -- o "rsg"

Config.Effects = {
    ['clean'] = function()
        local ped = PlayerPedId()
        ClearPedEnvDirt(ped)
        ClearPedDamageDecalByZone(ped, 10, 'ALL')
        ClearPedBloodDamage(ped)
    end
}

Config.Interactions = { -- List of interactable types of objects.
    -- Pianos
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_piano03x'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.70,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_piano02x'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.70,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_nbxpiano01x'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = -0.1,
        y = -0.75,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_nbmpiano01x'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.77,
        z = 0.5,
        heading = 0.0
    },
    {
        objects = {'sha_man_piano01'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.75,
        z = 0.5,
        heading = 0.0
    },
    {
        isCompatible = IsPedAdult,
        objects = GenericChairs,
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdult,
        objects = {'p_chairrusticsav01x'},
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = -0.1,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_bench11x'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_bench11x'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'p_bench11x'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'p_bench11x'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdult,
        objects = {'p_chairtall01x'},
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.8,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_barstool01x'},
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.8,
        heading = 0.0
    },
    {
        isCompatible = IsPedChild,
        objects = GenericChairs,
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.4,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanFemale,
        objects = GenericBenches,
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanFemale,
        objects = GenericBenches,
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = GenericBenches,
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = GenericBenches,
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {
            'p_bench17x',
            'p_benchbear01x'
        },
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.3,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bench17x',
            'p_benchbear01x'
        },
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.3,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bed14x',
            'p_bed17x',
            'p_bed21x',
            'p_bedbunk03x',
            'p_bedindian02x',
            'p_cot01x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bed20madex',
            'p_cs_pro_bed_unmade',
            'p_cs_bed20madex'
        },
        label = 'right',
        radius = 2.0,
        scenarios = BedScenarios,
        x = -0.3,
        y = -0.2,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bed20madex',
            'p_cs_pro_bed_unmade',
            'p_cs_bed20madex'
        },
        label = 'left',
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.3,
        y = -0.2,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_ambbed01x',
            'p_bed03x',
            'p_bed09x',
            'p_bedindian01x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.5,
        heading = 270.0
    },
    {
        objects = {
            'p_bed05x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.0,
        y = -0.5,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bed10x',
            'p_bed12x',
            'p_bed13x',
            'p_bed22x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.0,
        y = -0.3,
        z = 0.8,
        heading = 180.0
    },
    {
        objects = {
            'p_bed20x'
        },
        label = 'right',
        radius = 2.0,
        scenarios = BedScenarios,
        x = -0.3,
        y = -0.2,
        z = 0.8,
        heading = 180.0
    },
    {
        objects = {
            'p_bed20x'
        },
        label = 'left',
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.3,
        y = -0.2,
        z = 0.8,
        heading = 180.0
    },
    {
        objects = {
            'p_bedking02x'
        },
        label = 'left',
        radius = 2.0,
        scenarios = BedScenarios,
        x = -0.5,
        y = 0.5,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bedking02x'
        },
        label = 'right',
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.5,
        y = 0.5,
        z = 0.5,
        heading = 180.0
    },
    {
        objects = {
            'p_bedrollopen01x',
            'p_bedrollopen03x',
            'p_re_bedrollopen01x',
            's_bedrollfurlined01x',
            's_bedrollopen01x',
            'p_amb_mattress04x',
            'p_mattress04x',
            'p_mattress07x',
            'p_mattresscombined01x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.0,
        y = 0.0,
        z = 0.0,
        heading = 180.0
    },
    {
        objects = {
            'p_cs_ann_wrkr_bed01x',
            'p_cs_roc_hse_bed',
            'p_medbed01x'
        },
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.1,
        y = 0.0,
        z = 0.85,
        heading = 270.0
    },
    {
        objects = {
            'p_cs_bedsleptinbed08x'
        },
        label = 'left',
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.3,
        y = -0.3,
        z = 0.5,
        heading = 270.0
    },
    {
        objects = {
            'p_cs_bedsleptinbed08x'
        },
        label = 'right',
        radius = 2.0,
        scenarios = BedScenarios,
        x = 0.3,
        y = 0.3,
        z = 0.5,
        heading = 270.0
    },

    ---- Custom
    -- St. Denis Chruch Chair
    {
        isCompatible = IsPedAdult,
        objects = {'sdchurchchair'},
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = -0.1,
        z = -0.1,
        heading = 180.0
    },
    -- St. Denis Chruch Bench
    {
        isCompatible = IsPedHumanMale,
        objects = {'sdchurchbench'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = -0.3,
        z = -0.375,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'sdchurchbench'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = -0.3,
        z = -0.375,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'sdchurchbench'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.5,
        y = -0.3,
        z = -0.375,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'sdchurchbench'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.5,
        y = -0.3,
        z = -0.375,
        heading = 180.0
    },
    -- St. Denis Chruch Organ
    {
        isCompatible = IsPedHumanMale,
        objects = {'pipeorgan'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.70,
        z = -0.65,
        heading = 0.0
    },
    {
        isCompatible = IsPedHumanFemale,
        objects = {'pipeorgan'},
        radius = 2.0,
        scenarios = PianoScenarios,
        x = 0.0,
        y = -0.70,
        z = -0.625,
        heading = 0.0
    },
    -- Shoe stand
    {
        isCompatible = IsPedHumanFemale,
        objects = {'p_shoeshinestand01x'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.45,
        y = 0.25,
        z = 1.2,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanFemale,
        objects = {'p_shoeshinestand01x'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.45,
        y = 0.25,
        z = 1.2,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_shoeshinestand01x'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -0.45,
        y = 0.25,
        z = 1.2,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'p_shoeshinestand01x'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.45,
        y = 0.25,
        z = 1.2,
        heading = 180.0
    },
    -- Valentine Church Bench
    {
        isCompatible = IsPedHumanMale,
        objects = {'churchbench1'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -1.5,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'churchbench1'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'churchbench1'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = -1.5,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'churchbench1'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'churchbench2'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedHumanMale,
        objects = {'churchbench2'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 1.5,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'churchbench2'},
        label = 'left',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 0.0,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
    {
        isCompatible = IsPedAdultFemale,
        objects = {'churchbench2'},
        label = 'right',
        radius = 2.0,
        scenarios = GenericChairAndBenchScenarios,
        x = 1.5,
        y = 0.0,
        z = -0.3,
        heading = 180.0
    },
}

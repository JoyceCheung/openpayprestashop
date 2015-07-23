{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2015 PrestaShop SA
*  @license   http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}


{capture name=path}
    <a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'htmlall':'UTF-8'}" title="{l s='Go back to the Checkout' mod='openpayprestashop'}">{l s='Checkout' mod='openpayprestashop'}</a><span class="navigation-pipe">{$navigationPipe|escape:'htmlall':'UTF-8'}</span>{l s='Pago con tarjeta de cŕedito/débito' mod='openpayprestashop'}
{/capture}

<h2>{l s='Resumen del pedido ' mod='openpayprestashop'}</h2>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if $nbProducts <= 0}
    <p class="warning">Tu carrito esta vacío.</p>
{else}

    <div id="card-container" class="payment_module">
        <div class="openpay-form-container" >
            <div class="row mt30 mb10">
                <div class="col-md-3 store-image" style="border-right: 1px solid #ccc;">
                    <h3 class="openpay_title">Tarjetas de crédito</h3>
                    <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/credit_cards.png">
                </div>
                <div class="col-md-6 store-image">
                    <h3 class="openpay_title">Tarjetas de débito</h3>
                    <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/debit_cards.png">
                </div>
            </div>

            <div id="openpay-ajax-loader"><img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/ajax-loader.gif" alt="" /> Estamos registrando tu pago, por favor espera.</div>
            <form action="{$validation_url|escape:'htmlall':'UTF-8'}" method="POST" id="openpay-payment-form">
                <input type="hidden" name="payment_method" value="card" id="payment_method">
                <br>
                <div class="openpay-payment-errors">{if isset($openpay_error)}{$openpay_error|escape:'htmlall':'UTF-8'}{/if}</div>
                <a name="openpay_error" style="display:none"></a>

                <div class="row">
                    <div class="col-md-4">
                        <label>Nombre del tarjetahabiente</label><br />
                        <input type="text" autocomplete="off" id="holder_name" data-openpay-card="holder_name" class="form-control" placeholder="Como aparece en la tarjeta" />
                    </div>
                    <div class="col-md-4">
                        <label>Número de tarjeta</label><br />
                        <input type="text" autocomplete="off" id="card_number" data-openpay-card="card_number" class="form-control" placeholder="•••• •••• •••• ••••" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">

                        <label>FECHA DE EXPIRACIÓN</label><br />
                        <select id="expiration_month" data-openpay-card="expiration_month" class="openpay-card-expiry-month">
                            <option value="01">Enero</option>
                            <option value="02">Febrero</option>
                            <option value="03">Marzo</option>
                            <option value="04">Abril</option>
                            <option value="05">Mayo</option>
                            <option value="06">Junio</option>
                            <option value="07">Julio</option>
                            <option value="08">Agosto</option>
                            <option value="09">Septiembre</option>
                            <option value="10">Octubre</option>
                            <option value="11">Noviembre</option>
                            <option value="12">Diciembre</option>
                        </select>
                        <span> / </span>
                        <select id="expiration_year" data-openpay-card="expiration_year" class="openpay-card-expiry-year">
                            {assign var='startyear' value=$smarty.now|date_format:"%y"}
                            {assign var='endyear' value=($smarty.now|date_format:"%y" + 10)}

                            {for $i=$startyear to $endyear}
                                <option value="{$i|escape:'htmlall':'UTF-8'}">20{$i|escape:'htmlall':'UTF-8'}</option>
                            {/for}
                        </select>

                    </div>

                    <div class="col-md-2">
                        <label>Código de seguridad</label><br />
                        <input id="cvv2" type="password" size="4" autocomplete="off" data-openpay-card="cvv2" class="form-control" placeholder="CVV" />
                    </div>

                    <div class="col-md-2">
                        <br />
                        <a href="javascript:void(0)" class="" style="border: none;" data-toggle="popover" data-content="{l s='MasterCard y VISA presentan este código código de tres dígitos en el dorso de la tarjeta.' mod='openpayprestashop'}" >
                            <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/cvc_back.png">
                        </a>
                        <a href="javascript:void(0)" class="openpay-card-cvc-info" style="border: none;" data-toggle="popover" data-content="{l s='American Express presenta este código código de tres dígitos en la parte frontal de la tarjeta.' mod='openpayprestashop'}">
                            <img src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/cvc_front.png">
                        </a>
                    </div>

                </div>

        </div>
    </div>

    <p class="cart_navigation mt30">
        <a href="{$link->getPageLink('order', true, NULL, "step=3")|escape:'htmlall':'UTF-8'}" class="button-exclusive btn btn-default"><i class="icon-chevron-left"></i> Otros modos de pago </a>
        <button type="submit"  class="button btn btn-default standard-checkout button-medium">
            <span>
                Realizar pago
                <i class="icon-chevron-right right"></i>
            </span>
        </button>
    </p>

    </form>

    <script type="text/javascript">

        $(document).ready(function() {

            var openpay_public_key = "{$pk|escape:'htmlall':'UTF-8'}";
            var openpay_merchant_id = "{$id|escape:'htmlall':'UTF-8'}";
            var mode = "{$mode|escape:'htmlall':'UTF-8'}";

            $('[data-toggle="popover"]').popover({
                trigger: 'hover',
                'placement': 'top'
            });

            $('#card_number').cardNumberInput();

            OpenPay.setId(openpay_merchant_id);
            OpenPay.setApiKey(openpay_public_key);
            OpenPay.setSandboxMode(mode);

            //antifraudes
            OpenPay.deviceData.setup("openpay-payment-form", "device_session_id");

            $('#openpay-payment-form').submit(function(event) {
                event.preventDefault();

                $('.openpay-payment-errors').hide();
                $('#openpay-payment-form').hide();
                $('#openpay-ajax-loader').show();
                $('.openpay-submit-button').prop('disabled', true); /* Disable the submit button to prevent repeated clicks */

                return openpayFormHandler();
            });

            /* Catch callback errors */
            if ($('.openpay-payment-errors').text()){
                $('.openpay-payment-errors').fadeIn(1000);
            }

        });

        function openpayFormHandler() {
            var holder_name = jQuery('#holder_name').val();
            var card = jQuery('#card_number').val();
            var cvc = jQuery('#cvv2').val();
            var year = jQuery('#expiration_year').val();
            var month = jQuery('#expiration_month').val();

            var data = {
                holder_name: holder_name,
                card_number: card.replace(/ /g, ''),
                expiration_month: month || 0,
                expiration_year: year || 0,
                cvv2: cvc
            };

            OpenPay.token.create(data, success_callbak, error_callbak);

            return false;
        }



        var success_callbak = function(response) {
            $('.openpay-payment-errors').hide();
            var token_id = response.data.id;
            $('#openpay-payment-form').append('<input type="hidden" name="openpayToken" value="' + escape(token_id) + '" />');
            $('#openpay-payment-form').get(0).submit();
        };


        var error_callbak = function(response) {

            $('.openpay-payment-errors').fadeIn(1000);
            $('.openpay-payment-errors').text('ERROR ' + response.data.error_code + '. ' + response.message).fadeIn(1000);
            $('.openpay-submit-button').prop('disabled', false);
            $('#openpay-payment-form').show();
            $('#openpay-ajax-loader').hide();

        };

    </script>

{/if}
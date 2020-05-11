{*
Copyright 2017-2020 Nick Korbel

This file is part of Booked Scheduler.

Booked Scheduler is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Booked Scheduler is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Booked Scheduler.  If not, see <http://www.gnu.org/licenses/>.
*}

<div class="dashboard dashboard availabilityDashboard" id="availabilityDashboard">
    <div class="dashboardHeader">
        <div class="left">{translate key="ResourceAvailability"}</div>
        <div class="right">
            <a href="#" title="{translate key=ShowHide} {translate key="ResourceAvailability"}">
                <i class="fas fa-chevron-down"></i>
                <span class="no-show">Expand/Collapse</span>
            </a>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="dashboardContents">
        <div class="header">{translate key=Available}</div>
        {if $Available|count == 0}
            <div class="no-data">{translate key=None}</div>
        {else}
            {foreach from=$Schedules item=s}
            <h5>{$s->GetName()}</h5>
            {assign var=availability value=$Available[$s->GetId()]}
            {if is_array($availability) && $availability|count > 0}
            {foreach from=$availability item=i}
                <div class="availabilityItem row">
                    <div class="col s12 m4">
                        <i resource-id="{$i->ResourceId()}" class="resourceNameSelector fa fa-info-circle hide-on-large-only"></i>
                        <div class="resourceName" style="background-color:{$i->GetColor()};color:{$i->GetTextColor()};">
                            <a href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}"
                               resource-id="{$i->ResourceId()}"
                               class="resourceNameSelector" style="color:{$i->GetTextColor()}">{$i->ResourceName()}</a>
                        </div>
                    </div>
                    <div class="availability col s12 m5">
                        {if $i->NextTime() != null}
                            {translate key=AvailableUntil}
                            {format_date date=$i->NextTime() timezone=$Timezone key=dashboard}
                        {else}
                            <span class="no-data">{translate key=AllNoUpcomingReservations args=30}</span>
                        {/if}
                    </div>
                    <div class="reserveButton col s12 m3">
                        <a class="btn btn-small col s12"
                           href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}">{translate key=Reserve}</a>
                    </div>
                    <div class="clearfix"></div>
                </div>
            {/foreach}
            {else}
                <div class="no-data">{translate key=None}</div>
            {/if}
        {/foreach}
        {/if}

        <div class="header">{translate key=Unavailable}</div>
        {if $Unavailable|count == 0}
            <div class="no-data">{translate key=None}</div>
        {else}
            {foreach from=$Schedules item=s}
            <h5>{$s->GetName()}</h5>
            {assign var=availability value=$Unavailable[$s->GetId()]}
            {if is_array($availability) && $availability|count > 0}
            {foreach from=$availability item=i}
                <div class="availabilityItem row">
                    <div class="col s12 m4">
                        <i resource-id="{$i->ResourceId()}" class="resourceNameSelector fa fa-info-circle hide-on-large-only"></i>
                        <div class="resourceName" style="background-color:{$i->GetColor()};color:{$i->GetTextColor()};">
                            <a href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}"
                               resource-id="{$i->ResourceId()}"
                               class="resourceNameSelector" style="color:{$i->GetTextColor()}">{$i->ResourceName()}</a>
                        </div>
                    </div>
                    <div class="availability col s12 m5">
                        {translate key=AvailableBeginningAt} {format_date date=$i->ReservationEnds() timezone=$Timezone key=dashboard}
                    </div>
                    <div class="reserveButton col s12 m3">
                        <a class="btn btn-small col s12"
                           href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}&{QueryStringKeys::START_DATE}={format_date date=$i->ReservationEnds() timezone=$Timezone key=url_full}">{translate key=Reserve}</a>
                    </div>
                </div>
                <div class="clearfix"></div>
            {/foreach}
            {else}
                <div class="no-data">{translate key=None}</div>
            {/if}
        {/foreach}
        {/if}

        <div class="header">{translate key=UnavailableAllDay}</div>
        {if $UnavailableAllDay|count == 0}
            <div class="no-data">{translate key=None}</div>
        {else}
            {foreach from=$Schedules item=s}
            <h5>{$s->GetName()}</h5>
            {assign var=availability value=$UnavailableAllDay[$s->GetId()]}
            {if is_array($availability) && $availability|count > 0}
                {foreach from=$availability item=i}
                    <div class="availabilityItem row">
                        <div class="col s12 m4">
                            <i resource-id="{$i->ResourceId()}" class="resourceNameSelector fa fa-info-circle hide-on-large-only"></i>
                            <div class="resourceName" style="background-color:{$i->GetColor()};color:{$i->GetTextColor()};">
                                <a href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}"
                                   resource-id="{$i->ResourceId()}"
                                   class="resourceNameSelector" style="color:{$i->GetTextColor()}">{$i->ResourceName()}</a>
                            </div>
                        </div>
                        <div class="availability col s12 m5">
                            {translate key=AvailableAt} {format_date date=$i->ReservationEnds() timezone=$Timezone key=dashboard}
                        </div>
                        <div class="reserveButton col s12 m3">
                            <a class="btn btn-small col s12"
                               href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}&{QueryStringKeys::START_DATE}={format_date date=$i->ReservationEnds() timezone=$Timezone key=url_full}">{translate key=Reserve}</a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                {/foreach}
            {else}
                <div class="no-data">{translate key=None}</div>
            {/if}
        {/foreach}
        {/if}
    </div>
</div>